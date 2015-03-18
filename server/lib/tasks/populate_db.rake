module Graph
  class Ingredient
    def tastes *profiles
      neo_prof = profiles.map do |profile|
        Graph::FlavorProfile.find_or_create_by(name: profile)
      end
      
      self.flavors << neo_prof
      self.save if persisted?
      self
    end

    def with_group *groups
      self.groups << groups
      self
    end
  end

  class Recipe
    def add_ingredient ingredient, **attributes
      Graph::MadeWith.create(
        from_node: self,
        to_node: ingredient,
        **attributes
      )
      self
    end
  end
end

def ingredient(name, groups)
  igs = [*groups].map do |group|
    group.is_a?(Graph::IngredientGroup) ? group : Graph::IngredientGroup.find_or_create_by(name: group)
  end
  
  Graph::Ingredient.find_or_create_by(name: name).tap { |i| i.groups << igs }
end

def group(name)
  Graph::IngredientGroup.find_or_create_by(name: name)
end

def flavor(name)
  Graph::FlavorProfile.find_or_create_by(name: name)
end

namespace :db do
  task populate: :environment do
    if HighLine.agree('This will delete all current data. Do you want to proceed? (y/n)')

      # Delete nodes and relationships
      Neo4j::Session.query('START n = node(*) WITH n OPTIONAL MATCH n-[r]-() DELETE n, r;')

      puts 'All existing data has been deleted. Creating new data.'
      
      animal_prod = group('Animal Products')

      eggs = ingredient('egg', animal_prod).tastes('Savory')
      ingredient('honey', animal_prod).tastes('Sweet')

      meat = group('Meat')
      animal_prod.subgroups << meat

      beef = group('Beef')
      meat.subgroups << beef

      g_beef = group('Ground Beef')
      beef.subgroups << g_beef

      ingredient('ground beef (80/20)', g_beef).tastes('Savory')
      ingredient('ground beef (90/20)', g_beef).tastes('Savory')
      ingredient('sirloin steak', beef).tastes('Savory')
      ingredient('t-bone steak', beef).tastes('Savory')
      ingredient('filet mignon', beef).tastes('Savory')

      pork = group('Pork')
      meat.subgroups << pork

      ingredient('pork chop', pork).tastes('Savory')
      ingredient('boston butt', pork).tastes('Savory')
      ingredient('ground pork', pork).tastes('Savory')

      vegetables = group('Vegetables')

      cruc = group('Cruciferous')
      lg = group('Leafy Green')
      vegetables.subgroups << [cruc, lg]

      ingredient('broccoli', cruc).tastes('Bitter')
      ingredient('brussels sprouts', cruc).tastes('Bitter')
      ingredient('collard greens', [cruc, lg]).tastes('Bitter')
      ingredient('bok choy', [cruc, lg]).tastes('Grassy')

      let = group('Lettuce')
      lg.subgroups << let

      ingredient('lettuce', let).tastes('Grassy')
      ingredient('arugula', [let, cruc]).tastes('Grassy', 'Spicy', 'Peppery')
      ingredient('butter lettuce', let).tastes('Grassy')
      ingredient('romaine lettuce', let).tastes('Grassy')
      ingredient('iceberg lettuce', let).tastes('Grassy')
      ingredient('watercress', [let, cruc]).tastes('Grassy', 'Spicy', 'Peppery')
      
      prep = group('Prepared Foods')
      tort = ingredient('corn tortilla', prep)
      
      spice = group('Spices and Seasonings')
      salt = ingredient('salt', spice)
      pepper = ingredient('pepper', spice).tastes('Spicy', 'Peppery')

      oils = group('Oils')
      olive_oil = ingredient('olive oil', oils)

      huevos = Graph::Recipe.create(
        title: 'Huevos Rancheros',
        description: 'Here is a description of the recipe. It should describe the recipe, why you want to make it, etc. It should\'t be too long, but it should at least introduce concepts, etc.',
        serves: 2,
        prep_time: 600,
        cooking_time: 1200
      ).add_ingredient(eggs, quantity: 2)
        .add_ingredient(salt, uncounted: true)
        .add_ingredient(pepper, uncounted: true)
        .add_ingredient(tort, quantity: 2)
        .add_ingredient(olive_oil, unit_quantity: 1, unit_type: 'teaspoon')
    else
      puts 'Task aborted.'
    end
  end
end
