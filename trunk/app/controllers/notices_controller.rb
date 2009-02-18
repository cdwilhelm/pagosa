class NoticesController < ApplicationController
  # GET /notices
  # GET /notices.xml
  def index
    @notices = Notice.find(:all, :conditions => {:project_id => params[:id]},:order => "id" )
    @project = Project.find(:all,:conditions => {:id => params[:id]})

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @notices }
    end
  end

  # GET /notices/1
  # GET /notices/1.xml
  def show
    @notice = Notice.find(params[:id])
    @project = @notice.project

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @notice }
    end
  end

  # GET /notices/new
  # GET /notices/new.xml
  def new
    @notice = Notice.new
    @notice.project_id = params[:id]
    @project = Project.find(:all,:conditions => {:id => @notice.project_id})
    @notice.user_id =1

    @categories = Category.find(:all, :conditions => {:project_id => @notice.project_id},:order => "name" ).map {|u| [u.name, u.id] }
    @releases = Release.find(:all, :conditions => {:project_id => @notice.project_id},:order => "name" ).map {|u| [u.name, u.id] }
    @impacts =  Impact.find(:all,:order => "name" ).map {|u| [u.name, u.id] }
    @statuses = Status.find(:all,:order => "name" ).map {|u| [u.name, u.id] }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @notice }
    end
  end

  # GET /notices/1/edit
  def edit
    @notice = Notice.find(params[:id])

    @project = Project.find(:all,:conditions => {:id => @notice.project_id})
    @categories = Category.find(:all, :conditions => {:project_id => @notice.project_id},:order => "name" ).map {|u| [u.name, u.id] }
    @releases = Release.find(:all, :conditions => {:project_id => @notice.project_id},:order => "name" ).map {|u| [u.name, u.id] }
    @impacts =  Impact.find(:all,:order => "name" ).map {|u| [u.name, u.id] }
    @statuses = Status.find(:all,:order => "name" ).map {|u| [u.name, u.id] }
  end

  # POST /notices
  # POST /notices.xml
  def create
    @notice = Notice.new(params[:notice])
    @notice.user_id=1

    respond_to do |format|
      if @notice.save
        flash[:notice] = 'Notice was successfully created.'
        format.html { redirect_to(@notice) }
        format.xml  { render :xml => @notice, :status => :created, :location => @notice }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @notice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /notices/1
  # PUT /notices/1.xml
  def update
    @notice = Notice.find(params[:id])

    respond_to do |format|
      if @notice.update_attributes(params[:notice])
        flash[:notice] = 'Notice was successfully updated.'
        format.html { redirect_to(@notice) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @notice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /notices/1
  # DELETE /notices/1.xml
  def destroy
    @notice = Notice.find(params[:id])
    @notice.destroy

    respond_to do |format|
      format.html { redirect_to(notices_url) }
      format.xml  { head :ok }
    end
  end
end
