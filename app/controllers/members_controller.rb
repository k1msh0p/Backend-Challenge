class MembersController < ApplicationController
  before_action :set_member, only: [:show, :define_friend, :save_friend, :search_expert, :search_expert_result]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
  	@members = Member.all
    Rails.logger.debug @members
  end

  # GET /members/new
 def new
  	@member = Member.new
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)
    
    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Your post is now live.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /1/member
  def show
    @friends = @member.friends
  end

  # Handling all record not found errors
  def record_not_found
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Record not found'  }      
      format.json { render json: { error: error.message }, status: :not_found }
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  # def destroy
  #   @member.destroy
  #   respond_to do |format|
  #     format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  # Define Friends
  def define_friend
    @non_friends = @member.non_friends
  end

  # Save friendship
  def save_friend
    Friend.where(member_id: @member.id, friend_id: params[:friend_id]).first_or_create
    @non_friends = @member.non_friends
    render :define_friend
  end

  # Search page for expert
  def search_expert
    
  end

  # Return search result of expert search
  def search_expert_result
    @result = []
    unless params[:search].empty?
      #Search for expert and connecting path if any
      #Expected result is ["Claude" => [ ["Alan","Bart","Claude"], ["Alan","Joe","Claude"] ]]
      experts_array = @member.search_for_expert(params[:search]) 
      #Parse connecting path to string
      #Possible output are:
      # - "No expert found"
      # - "Expert is Claude. None of your friends know Claude"
      # - "Expert is Claude. Your connecting path is Alan -> Joe -> Claude"
     if experts_array.empty?
        @result << "No expert found"
      else
        experts_array.each do |expert|
          expert.each do |key, paths| 
            if paths.nil? || paths.size == 0
              @result << "Expert is #{key}. None of your friends know #{key}"
            else
              formatted_path = ""
              paths.each do |p|
                path = ""
                path += p.map(&:inspect).join(' -> ') 
                formatted_path += "( #{path} )"
              end
              @result << "Expert is #{key}. Your connecting path(s): " + formatted_path
            end
          end                    
        end
      end
    end
    render :search_expert
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      
      @member = Member.find(params[:id])  
      
      rescue ActiveRecord::RecordNotFound
        raise RecordNotFound
    end

    def member_params
      params.require(:member).permit(:name, :website, :heading1, :heading2, :heading3)
    end

end
