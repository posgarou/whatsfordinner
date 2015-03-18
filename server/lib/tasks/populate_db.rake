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

    def add_steps steps
      steps.each_with_index do |step, i|
        self.steps << Graph::RecipeStep.create(number: i + 1, **step)
      end
      self
    end

    def add_tag name
      Graph::Tag.find_or_create_by(name: name)
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

def tag(name)
  Graph::Tag.find_or_create_by(name: name)
end

def setup_users
  3.times do
    user = User.create(
      name: 'Ryan',
      email: 'foo@foo.com',
      uid: SecureRandom.hex(10)
    )
    # Force creation of a graph user
    user.graph_user
  end
end

namespace :db do
  task populate: :environment do
    if HighLine.agree('This will delete all current data. Do you want to proceed? (y/n)')

      # Delete nodes and relationships
      Neo4j::Session.query('START n = node(*) WITH n OPTIONAL MATCH n-[r]-() DELETE n, r;')

      puts 'All existing data has been deleted. Creating new data.'

      setup_users
      
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

      fruits = group('Fruits')
      avocado = ingredient('avocado', fruits)

      gluten = group('Gluten-containing')
      toast = ingredient('toast', [prep, gluten])

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
        .add_tag('pan-fried')
        .add_steps([
            { text: 'Heat the oil in a large skillet over medium heat.' },
            { text: 'Place the tortillas inside the skillet.' },
            {
              text: 'Crack an egg over each tortilla. Salt and pepper each egg. Cook until the egg whites have solidified.',
              tip: 'If your oven surface isn\'t even, you may want to remove the pan to a level trivet while cracking the eggs. If you do this, balance the frying pan until the egg whites have started to solidify. Don\'t worry if the eggs start sliding off, though—the part that slides off gets crispy and delicious!'
            },
            {
              text: 'Use a flat spatula to flip each tortilla and egg so that the egg comes into direct contact with the pan. Cook to desired doneness.',
              optional: true,
              tip: 'This allows the egg to get some caramelization, and it also allows the egg to get cooked without the tortilla getting too crispy. But you can also serve the eggs and tortillas sunny-side-up.'
            },
            { text: 'Remove to individual plates and serve.' }
          ])
      fried_egg = Graph::Recipe.create(
        title: 'Fried Egg',
        description: 'Here is a description of the recipe. It should describe the recipe, why you want to make it, etc. It should\'t be too long, but it should at least introduce concepts, etc.',
        serves: 2,
        prep_time: 60,
        cooking_time: 300
      ).add_ingredient(eggs, quantity: 2)
        .add_ingredient(salt, uncounted: true)
        .add_ingredient(pepper, uncounted: true)
        .add_ingredient(olive_oil, unit_quantity: 1, unit_type: 'teaspoon')
        .add_tag('pan-fried')
        .add_steps([
          { text: 'Place a cast-iron skillet on the oven and preheat the burner to medium-high.' },
          { text: 'Once the skillet is radiating heat and a droplet of water dances on the pan, add the oil.' },
          { text: 'When the oil just starts to shimmer, crack the eggs into the pan.', tip: 'If you let the oil get too hot, it will burn. Don\'t leave the oil unattended (and also don\'t use too large of a pan.)' },
          { text: 'Season each egg with salt and pepper to taste.' },
          { text: 'Once the egg whites have solidified, place a flat spatula underneath each egg and flip it over.', tip: 'If you like your eggs well-done, you may have to lower the heat.' },
          { text: 'Cook the eggs until they have reached the desired level of doneness.' }
        ])

      avocado_and_toast = Graph::Recipe.create(
        title: 'Avocado and Toast',
        description: 'Here is a description of the recipe. It should describe the recipe, why you want to make it, etc. It should\'t be too long, but it should at least introduce concepts, etc.',
        serves: 2,
        cooking_time: 120
      ).add_ingredient(avocado)
      .add_ingredient(salt, uncounted: true)
      .add_ingredient(pepper, uncounted: true)
      .add_ingredient(toast, uncounted: true)
      .add_steps([
          { text: 'Cut the avocado in half.' },
          { text: 'Cut each half into slices about 1/4" thick.".' },
          { text: 'Layer the slices on the toast.' }
        ])
    else
      puts 'Task aborted.'
    end
  end
end
