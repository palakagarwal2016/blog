class PostsController < ApplicationController

  before_filter :getposts, :only => [:index, :show]
  before_filter :require_user, :except => [:index, :show]

  def getposts
    @posts = Post.order("created_at desc").page(params[:page]).per(4)
    @recent_posts = Post.order("created_at desc")
  end

  def index

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @posts }
      format.rss { render :layout => false }  #creates rss feed
    end
  end

  def show
    @post = Post.find(params[:id])
    @title = @post.title

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @post }
    end
  end

  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @post }
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to root_url, :notice => 'Post was successfully created.' }
        format.json { render :json => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, :notice => 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
    end
  end

end
