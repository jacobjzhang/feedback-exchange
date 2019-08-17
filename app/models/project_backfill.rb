require 'open-uri'

class ProjectBackfill
  def self.backfill
    url = "https://hacker-news.firebaseio.com/v0/showstories.json?print=pretty"
    json = open(url).read
    stories = JSON.parse(json)

    stories.each do |story_id|
      story_url = "https://hacker-news.firebaseio.com/v0/item/#{story_id}.json?print=pretty"
      story_json = open(story_url).read
      story = JSON.parse(story_json)

      if story['url'] && !story['url'].include?('medium')
        # hack
        begin
          project_hash = ProjectProcessor.retrieve_meta(story['url'])
          a = Project.new(project_hash.merge(stage_type: 'fake', user: User.fake.sample))
          puts a.valid?
          puts a.errors.messages
          a.save!
        rescue
          next
        end
      end
    end
  end
end