class CommentsController < ApplicationController
  # GET /comment
  # GET /comment.xml
  def index
    @comments = Comment.find(:all, :conditions =>{:notice_id => params[:notice_id]})
    @notice = Notice.find(:first, :conditions => {:id => params[:notice_id]})
    #@user = @current_user_id
    self.setup
    #for new form on index page
    @comment = Comment.new
    @comment.notice_id = params[:notice_id]
    @comment.user_id = current_user_id
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comment/1
  # GET /comment/1.xml
  def show
    @comment = Comment.find(params[:id])
    @notice = Notice.find(:first, :conditions => {:id =>@comment.notice_id})
    self.setup
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comment/new
  # GET /comment/new.xml
  def new
    @comment = Comment.new
    @comment.notice_id = params[:notice_id]
    @comment.user_id = current_user_id

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comment/1/edit
  def edit
    @comment = Comment.find(params[:id])
    @notice = Notice.find(:first, :conditions => {:id =>@comment.notice_id})
    self.setup
  end

  # POST /comment
  # POST /comment.xml
  def create
    @comment = Comment.new(params[:comment])

    respond_to do |format|
      if @comment.save
        flash[:notice] = 'comment was successfully created.'
        format.html { redirect_to(:action=> 'index', :notice_id=> @comment.notice_id) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comment/1
  # PUT /comment/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'comment was successfully updated.'
        format.html { redirect_to(@comment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comment/1
  # DELETE /comment/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(comment_url) }
      format.xml  { head :ok }
    end
  end


  def setup
     @project = Project.find(:first, :conditions => {:id => @notice.project_id})
  end
end
