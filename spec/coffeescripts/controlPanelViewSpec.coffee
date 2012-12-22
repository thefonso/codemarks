describe 'ControlPanelView', ->
  beforeEach ->
    @codemarks = new App.Codemarks
    @view = new App.ControlPanelView
      codemarks: @codemarks

  describe 'render', ->
    it 'makes one filter object if filtering by user', ->
      @codemarks.filters.setUser('jbieber')
      @view.render()
      expect(@view.$('.filter.user').length).toBe(1)

    it 'makes one filter object for each topic filter', ->
      @codemarks.filters.addTopic('rspec')
      @codemarks.filters.addTopic('jquery')
      @view.render()
      expect(@view.$('.filter.topic').length).toBe(2)

    it 'makes a filter object for a search filter', ->
      @codemarks.filters.setSearchQuery('This thing')
      @view.render()
      expect(@view.$('.filter.query').length).toBe(1)

    it 'makes a filter object for the sort', ->
      @view.render()
      expect(@view.$('.filter.sort').length).toBe(1)

    it 'makes a search bar', ->
      @view.render()
      expect(@view.$('input#search').length).toBe(1)

  describe 'search', ->
    describe 'gets triggered by', ->
      it 'clicking the search link', ->
        @view.render()
        spyOn(@view, 'search')
        @view.$('a.search').click()
        expect(@view.search).toHaveBeenCalled()

      it 'pressing enter in the search box', ->
        @view.render()
        spyOn(@view, 'search')
        keypress = $.Event('keypress')
        keypress.which = 13
        @view.$('input#search').trigger(keypress)

        expect(@view.search).toHaveBeenCalled()

    it 'sets a search filter and fetches new codemarks', ->
      @view.render()
      @view.$('#search').val('javascript')
      spyOn(@codemarks, 'fetch')
      @view.search()
      expect(@codemarks.fetch).toHaveBeenCalled()
      expect(@codemarks.filters.searchQuery()).toBe('javascript')

    it 'does not search if nothing has been entered', ->
      @view.render()
      spyOn(@codemarks, 'fetch')
      @view.search()
      expect(@codemarks.fetch).not.toHaveBeenCalled()