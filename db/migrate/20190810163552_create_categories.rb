class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.string :label

      t.timestamps
    end

    # categories = [
    #   ['arts', 'Arts'],
    #   ['business', 'Business'],
    #   ['computers', 'Computers'],
    #   ['content', 'Content'],    
    #   ['education', 'Education'],
    #   ['games', 'Games'],
    #   ['health', 'Health'],
    #   ['home', 'Home'],
    #   ['kids-and-teens', 'Kids and Teens'],
    #   ['news', 'News'],
    #   ['recreation', 'Recreation'],
    #   ['reference', 'Reference'],
    #   ['regional', 'Regional'],
    #   ['saas', 'Software as a Service'],
    #   ['science', 'Science'],
    #   ['shopping', 'Shopping'],
    #   ['society', 'Society'],
    #   ['sports', 'Sports'],
    #   ['world', 'World']
    # ]

    # categories.each do |c|
    #   Category.create!(name: c[0], label: c[1])
    # end
  end
end
