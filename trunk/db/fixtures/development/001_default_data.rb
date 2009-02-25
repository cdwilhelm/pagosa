

Project.create!(:name => 'pagosa',
  :display_name => 'Pagosa',
  :description => 'Integration Tool')

Project.create!(:name => 'codegen',
  :display_name => 'codegen',
  :description => 'code generator')

Project.create!(:name => 'releasetools',
  :display_name => 'releasetools',
  :description => 'Release tools')

User.create!(
  :name => "Curt Wilhelm",
  :email => "curt.wilhelm@yahoo.com",
  :login => "cwilhelm",
  :salt => "NaC1",
  :hashed_password => User.encrypted_password('FooBar', 'NaC1')
)

User.create!(
  :name => "Russ Tremain",
  :email => "rtremain@covad.net",
  :login => "rtremain",
  :salt => "NaC1",
  :hashed_password => User.encrypted_password('FooBar', 'NaC1')
)
User.create!(
  :name => "anonymous",
  :email => "user",
  :login => "user",
  :salt => "NaC1",
  :hashed_password => User.encrypted_password('FooBar', 'NaC1')
)
Notice.create!(
  :subject => "This is a new Integration for pagosa",
  :description => "More data about this integration",
  :project_id => 1,
  :user_id => 1,
  :category_id => 1,
  :status_id => 1,
  :impact_id =>1,
  :release_id =>1
)
Notice.create!(
  :subject => "This is a new Integration for codegen",
  :description => "More data about this integration",
  :project_id => 2,
  :user_id => 2,
  :category_id => 2,
  :status_id => 3,
  :impact_id => 2,
  :release_id =>1
)

Category.create!(
  :name => "Tool",
  :description => "Tool Stuff",
  :project_id => 1
)

Category.create!(
  :name => "Tool",
  :description => "Tool Stuff",
  :project_id => 2
)

Category.create!(
  :name => "Web",
  :description => "Web site",
  :project_id => 2
)

Status.create!(
  :name => "Open"
)
Status.create!(
  :name => "Closed"
)
Status.create!(
  :name => "Draft"
)
Status.create!(
  :name => "Planned"
)
Status.create!(
  :name => "Integrated"
)

Impact.create!(
  :name => "High"
)
Impact.create!(:name => "Low")

Release.create!(:project_id=>1,:name => "codename",:description => "first release", :version=>"1.0")
Release.create!(:project_id=>2,:name => "codename",:description => "first release", :version=>"1.0")
Release.create!(:project_id=>3,:name => "codename",:description => "first release", :version=>"1.0")

Comment.create!(
:notice_id=>2,
:comment => "new comment",
:user_id=> 1
)
Comment.create!(
:notice_id=>1,
:comment => "new comment",
:user_id=> 2
)