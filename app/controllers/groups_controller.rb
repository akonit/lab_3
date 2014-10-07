class GroupsController < ApplicationController
	
	http_basic_authenticate_with name: "admin", password: "admin", except: [:index, :show]


	def new
		@group = Group.new
		@faculty = Faculty.find(params[:faculty_id])
	end

    def create
    	@group = Group.new(group_params)
		@faculty = Faculty.find(params[:faculty_id])
 
		@faculty.groups << @group
        if @faculty.save
            redirect_to group_path(@group, :faculty_id => @faculty.id)
	    else
	        render 'new'
	    end
    end

	def edit
		@faculty = Faculty.find(params[:faculty_id])
	    @group = @faculty.groups.select { |b| b.id.to_s == params[:id]}.first
	end

	def update
		@faculty = Faculty.find(params[:faculty_id])
	    @group = @faculty.groups.select { |b| b.id.to_s == params[:id]}.first
	    @group.cource = group_params[:cource]
	    @group.name = group_params[:name]

	    if @group.save
	        redirect_to group_path(@group, :faculty_id => @faculty.id)
	    else
	        render 'edit'
	    end
	end

    def show
		@faculty = Faculty.find(params[:faculty_id])
        @group = @faculty.groups.select { |b| b.id.to_s == params[:id]}.first
	  	@days = ["Monday",
	        "Tuesday",
	        "Wednesday",
	        "Thursday",
	        "Friday",
	        "Saturday"]
    end

	def destroy
		@faculty = Faculty.find(params[:faculty_id])
		@faculty.groups.delete_if{ |group| group.id.to_s == params[:id]}
	    if @faculty.save
	  	    redirect_to @faculty
	  	end
	end

    private
	    def group_params
	        params.require(:group).permit(:cource, :name, :faculty_id)
	    end
end
