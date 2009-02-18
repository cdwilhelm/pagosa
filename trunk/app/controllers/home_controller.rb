class HomeController < ApplicationController

  def index
    @projects = Project.find(:all, :order => "name")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end
end