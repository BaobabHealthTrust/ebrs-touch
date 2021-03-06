class UsersController < ApplicationController

  #Displays User Management Section
  def index

    @icoFolder = icoFolder("icoFolder")
    #raise @icoFolder.inspect
    @section = "User Management"

    @targeturl = "/"

    @targettext = "Finish"

    render :layout => "facility"
  end

  #Displays The Created User
  def show

    @section = "View User"

    @user = User.find(params[:id])

    @person_name = PersonName.find_by_person_id(@user.person_id)

    @user_role = UserRole.find(@user.user_role_id)

    @targeturl = "/view_users"

    render :layout => "facility"

  end

  #Displays All Users
  def view

    @users = User.all.each

    @section = "View Users"

    @targeturl = "/users"

    render :layout => "facility"
  end

  #Adds A New User
  def new

    @user = User.new

    @section = "Create User"

    @targeturl = "/user"

    render :layout => "touch"

  end

  # Edits Selected User
  def edit

    #redirect_to "/" and return if !(User.current_user.activities_by_level("Facility").include?("Update User"))

    @user = User.find(params[:id])

    @section = "Edit User"

    @targeturl = "/view_users"

    render :layout => "touch"

  end

  #Creates A New User
  def create

      @targeturl = "/user"
      #user = User.find(params[:user]['username'])

      #if user.present?
        #flash["notice"] = "User already already exists"
         #redirect_to "/user/new" and return
      #end
      core_person = CorePerson.create(person_type_id: 1)
      person_name = PersonName.create(person_id: core_person.person_id, first_name: params[:user]['person']['first_name'], last_name: params[:user]['person']['last_name'] )
      person_name_code = PersonNameCode.create(person_name_id: person_name.person_name_id, first_name_code: params[:user]['person']['first_name'].soundex, last_name_code: params[:user]['person']['last_name'].soundex )

      user_role = UserRole.create(role: params[:user]['user_role']['role'], level: 1, voided: 0)

      @user = User.create(username: params[:user]['username'], plain_password: params[:user]['plain_password'], location_id: 1, uuid: 1, user_role_id:     	 user_role.user_role_id,  email: params[:user]['email'], person_id: core_person.person_id)

      respond_to do |format|

      if @user.present?
        format.html { redirect_to @user, :notice => 'User was successfully created.' }
        format.json { render :show, :status => :created, :location => @user }
      else
        format.html { render :new }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update

    if request.referrer.match('edit_account')
      @current_user.preferred_keyboard = params[:user][:preferred_keyboard]
      @current_user.save!
      redirect_to '/users/my_account' and return
    end

    if params[:user][:plain_password].present? && params[:user][:plain_password].length > 1
      @user.update_attributes(:password_hash => params[:user][:plain_password], :password_attempt => 0, :last_password_date => Time.now)

    end

    respond_to do |format|
      #if ((User.current_user.role.strip.downcase.match(/admin/) rescue false) ? true : false) and @user.update_attributes(user_params)

        if @user.present?
        format.html { redirect_to @user, :notice => 'User was successfully updated.' }
        format.json { render :show, :status => :ok, :location => @user }
        else
        format.html { render :edit }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
      end
  end

  #Displays All Users
  def query_users

    results = []

    users = User.all
      users.each do |user|
    	next if user.core_person.blank? || user.core_person.person_name.blank?

    	record = {
          	"username" => "#{user.username}",
          	"name" => "#{user.core_person.person_name.first_name} #{user.core_person.person_name.last_name}",
          	#"role" => "#{user.user_role.role}",
          	"user_id" => "#{user.user_id}",
         	"active" => (user.active rescue false)
      	    	}

      	results << record
    end

    render :text => results.to_json
  end

  #Deletes Selected User
  def destroy

    @user.destroy if ((User.current_user.role.strip.downcase.match(/admin/) rescue false) ? true : false)
      respond_to do |format|
      format.html { redirect_to "/view_users", :notice => 'User was successfully destroyed.' }
      format.json { head :no_content }
    end

  end

  #Revokes User Access Rights
  def block

    @users = User.all.each

    @section = "Block User"

    @targeturl = "/users"

    render :layout => "facility"

  end

  #Gives Back Bloked User Access Rights
  def unblock

    @users = User.all.each

    @section = "Unblock User"

    @targeturl = "/users"

    render :layout => "facility"

  end

  #Revokes User Access Rights
  def block_user

    user = User.find(params[:id]) rescue nil

    if !user.nil?

      user.update_attributes(:active => false, :un_or_block_reason => params[:reason]) if ((User.current_user.role.strip.downcase.match(/admin/) rescue false) ? true : false)

    end

    redirect_to "/view_users" and return

  end

  #Gives Back Bloked User Access Rights
  def unblock_user

    user = User.find(params[:id]) rescue nil

    if !user.nil?

      user.update_attributes(:active => true, :un_or_block_reason => params[:reason]) if ((User.current_user.role.strip.downcase.match(/admin/) rescue false) ? true : false)
    end

    redirect_to "/view_users" and return

  end

  def search

    #redirect_to "/" and return if !(User.current_user.activities_by_level("Facility").include?("View Users"))

    @section = "Search for User"

    @targeturl = "/users"

    render :layout => "facility"

  end

  def search_by_username

    #redirect_to "/" and return if !(User.current_user.activities_by_level("Facility").include?("View Users"))

    name = params[:id].strip rescue ""

    results = []

    if name.length > 1

      users = User.by_username.key(name).limit(10).each

    else

      users = User.by_username.limit(10).each

    end

    users.each do |user|

      next if user.username.strip.downcase == User.current_user.username.strip.downcase

      record = {
          "username" => "#{user.username}",
          "fname" => "#{user.core_person.person_name.first_name}",
          "lname" => "#{user.core_person.person_name.last_name}",
          "role" => "#{user.user_role.role}",
          "active" => (user.active rescue false)
      }

      results << record

    end

    render :text => results.to_json

  end

  def search_by_active

    #redirect_to "/" and return if !(User.current_user.activities_by_level("Facility").include?("View Users"))

    status = params[:status] == "true" ? true : false

    results = []

    users = User.by_active.key(status).limit(10).each

    users.each do |user|

      next if user.username.strip.downcase == User.current_user.username.strip.downcase

      record = {
          "username" => "#{user.username}",
          "fname" => "#{user.core_person.person_name.first_name}",
          "lname" => "#{user.core_person.person_name.last_name}",
          "role" => "#{user.user_role.role}",
          "active" => (user.active rescue false)
      }

      results << record

    end

    render :text => results.to_json

  end



  def username_availability
    user = User.get_active_user(params[:search_str])
    render :text => user = user.blank? ? 'OK' : 'N/A' and return
  end

  def my_account
    #redirect_to "/" and return if !(User.current_user.activities_by_level("Facility").include?("Change own password"))

    @section = "My Account"

    @targeturl = "/"

    @user = User.current_user

    render :layout => "facility"

  end

  def change_password
    #redirect_to "/" and return if !(User.current_user.activities_by_level("Facility").include?("Change own password"))

    @section = "Change Password"

    @targeturl = "/"

    @user = User.current_user

    render :layout => "facility"

  end

  def update_password

    user = User.current_user

    result = user.password_matches?(params[:old_password])

    if user && !user.password_matches?(params[:old_password])
    	 result = "not same"
    elsif user && user.password_matches?(params[:new_password])
    	 result = "same"
    else
      user.update_attributes(:password_hash => params[:new_password], :password_attempt => 0, :last_password_date => Time.now)
      flash["notice"] = "Your new password has been changed succesfully"

    end

    render :text => result

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:username, :active, :create_at, :creator, :email, :first_name, :last_name, :notify, :plain_password, :role, :updated_at, :_rev)
  end

  def check_if_user_admin

    @search = icoFolder("search")

    @admin = ((User.current_user.role.strip.downcase.match(/admin/) rescue false) ? true : false)

  end


end
