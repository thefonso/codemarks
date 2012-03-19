class CodemarksController < ApplicationController

  def new
    options = {}
    options[:url] = params[:url]
    options[:user_id] = params[:user_id] if params[:user_id]
    @codemark = Codemark.load(options)
  end

  def create
    topic_ids = params[:tags].keys.collect(&:to_i) if params[:tags]
    topic_ids ||= []

    new_topic_titles = params[:topic_ids].keys if params[:topic_ids] 

    @codemark = Codemark.create(params[:codemark_attrs], 
                                params[:resource_attrs], 
                                topic_ids, 
                                current_user, 
                                :new_topic_titles => new_topic_titles)

    redirect_to :back, :notice => 'Thanks!'
  end

  def public
    search_attributes = {}
    search_attributes[:page] = params[:page] if params[:page]
    search_attributes[:by] = params[:by] if params[:by]
    @codemarks = FindCodemarks.new(search_attributes).codemarks

    render 'users/dashboard'
  end

  def destroy
    @codemark = CodemarkRecord.find(params[:id])
    @codemark.destroy

    respond_to do |format|
      format.js
    end
  end

end
