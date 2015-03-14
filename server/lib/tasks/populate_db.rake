module Graph
  class Ingredient
    def tastes *profiles
      self.flavors << profiles
      self
    end

    def with_group *groups
      self.groups << groups
      self
    end
  end
end

def new_ingredient(name, groups)
  Graph::Ingredient.create(name: name).tap { |i| i.groups << groups }
end

namespace :db do
  task populate: :environment do
    if HighLine.agree('This will delete all current data. Do you want to proceed? (y/n)')
      Rake::Task['neo4j:reset_yes_i_am_sure'].invoke('wfd-dev')
      puts 'All data has been deleted. Creating base data.'

      sweet = Graph::FlavorProfile.create(name: 'Sweet')
      sour = Graph::FlavorProfile.create(name: 'Sour')
      bitter = Graph::FlavorProfile.create(name: 'Bitter')
      salty = Graph::FlavorProfile.create(name: 'Salty')
      spicy = Graph::FlavorProfile.create(name: 'Spicy')
      savory = Graph::FlavorProfile.create(name: 'Savory')
      grassy = Graph::FlavorProfile.create(name: 'Grassy')

      ig = Graph::IngredientGroup

      animal_prod = ig.create(name: 'Animal Products')

      new_ingredient('Egg', animal_prod).tastes(savory)
      new_ingredient('Honey', animal_prod).tastes(sweet)

      meat = ig.create(name: 'Meat')
      animal_prod.subgroups << meat

      beef = ig.create(name: 'Beef')
      meat.subgroups << beef

      g_beef = ig.create(name: 'Ground Beef')
      beef.subgroups << g_beef

      new_ingredient('Ground Beef (80/20)', g_beef).tastes(savory)
      new_ingredient('Ground Beef (90/20)', g_beef).tastes(savory)
      new_ingredient('Sirloin Steak', beef).tastes(savory)
      new_ingredient('T-bone Steak', beef).tastes(savory)
      new_ingredient('Filet Mignon', beef).tastes(savory)

      pork = ig.create(name: 'Pork')
      meat.subgroups << pork

      new_ingredient('Pork Chop', pork).tastes(savory)
      new_ingredient('Boston Butt', pork).tastes(savory)
      new_ingredient('Ground Pork', pork).tastes(savory)

      vegetables = ig.create(name: 'Vegetables')

      cruc = ig.create(name: 'Cruciferous')
      lg = ig.create(name: 'Leafy Green')
      vegetables.subgroups << [cruc, lg]

      new_ingredient('Broccoli', cruc).tastes(bitter)
      new_ingredient('Brussels Sprouts', cruc).tastes(bitter)
      new_ingredient('Collard Greens', [cruc, lg]).tastes(bitter)
      new_ingredient('Bok Choy', [cruc, lg]).tastes(grassy)

      let = ig.create(name: 'Lettuce')
      lg.subgroups << let

      new_ingredient('Lettuce', let).tastes(grassy)
      new_ingredient('Arugula', [let, cruc]).tastes(grassy, spicy)
      new_ingredient('Butter Lettuce', let).tastes(grassy)
      new_ingredient('Romaine Lettuce', let).tastes(grassy)
      new_ingredient('Iceberg Lettuce', let).tastes(grassy)
      new_ingredient('Watercress', [let, cruc]).tastes(grassy, spicy)
    else
      puts 'Task aborted.'
    end
  end
end
