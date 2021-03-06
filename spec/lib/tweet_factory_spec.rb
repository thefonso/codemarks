require 'spec_helper'

describe TweetFactory do
  describe '#codemark_of_the_day' do
    before do
      bilty_response = mock(:short_url => 'http://google.com')
      bitly = mock(:bitly, :shorten => bilty_response)
      TweetFactory.any_instance.stub(:bitly => bitly)
    end

    it 'includes "Codemark of the Day!' do
      codemark = Fabricate(:codemark)
      TweetFactory.codemark_of_the_day(codemark).should include('#cmoftheday')
    end

    it 'contains a link' do
      codemark = Fabricate(:codemark)
      TweetFactory.codemark_of_the_day(codemark).should include('http')
    end

    it 'contains "via @nickname" for twitter users' do
      user = Fabricate(:twitter_user)
      codemark = Fabricate(:codemark, :user => user)
      TweetFactory.codemark_of_the_day(codemark).should include("via @#{user.nickname}")
    end

    it 'contains "via nickname" for github users' do
      user = Fabricate(:github_user)
      codemark = Fabricate(:codemark, :user => user)
      TweetFactory.codemark_of_the_day(codemark).should include("via #{user.nickname}")
    end

    it 'uses the resource author as user if possible' do
      user = Fabricate(:twitter_user)
      author = Fabricate(:twitter_user)
      codemark = Fabricate(:codemark, :user => user)
      codemark.resource = Link.new(:author => author)
      TweetFactory.codemark_of_the_day(codemark).should include("via @#{author.nickname}")
    end

    it 'should not contain two consecutive spaces' do
      codemark = Fabricate(:codemark)
      TweetFactory.codemark_of_the_day(codemark).should_not include '  '
    end

    it 'includes topics if there is room' do
      topic = Fabricate(:topic, :title => 'github')
      codemark = Fabricate(:codemark, :title => 'Check out github', :topics => [topic])
      TweetFactory.codemark_of_the_day(codemark).should include '#github'
    end

    it 'includes as many topics as there is room' do
      topics = 15.times.map { Fabricate(:topic) }
      codemark = Fabricate(:codemark, :title => '', :topics => topics)
      TweetFactory.codemark_of_the_day(codemark).length.should < TweetFactory::TWEET_LENGTH
    end
  end
end
