class LessonsController < ApplicationController

	http_basic_authenticate_with name: "admin", password: "admin", except: [:index, :show]


	def new
		@lesson = Lesson.new
		@faculty = Faculty.find(params[:faculty_id])
	    @group = @faculty.groups.select { |b| b.id.to_s == params[:group_id]}.first
	end

    def create
    	@lesson = Lesson.new(lesson_params)
		@faculty = Faculty.find(params[:faculty_id])
	    @group = @faculty.groups.select { |b| b.id.to_s == params[:group_id]}.first
 
		@group.lessons << @lesson
        if @group.save
            redirect_to lesson_path(@lesson, :faculty_id => @faculty.id, :group_id => @group.id)
	    else
	        render 'new'
	    end
    end

	def edit
		@faculty = Faculty.find(params[:faculty_id])
	    @group = @faculty.groups.select { |b| b.id.to_s == params[:group_id]}.first
	    @lesson = @group.lessons.select { |b| b.id.to_s == params[:id]}.first
	end

	def update
		@faculty = Faculty.find(params[:faculty_id])
	    @group = @faculty.groups.select { |b| b.id.to_s == params[:group_id]}.first
	    @lesson = @group.lessons.select { |b| b.id.to_s == params[:id]}.first
	    
	    @lesson.name = lesson_params[:name]
	    @lesson.teacher = lesson_params[:teacher]
	    @lesson.day = lesson_params[:day]
	    @lesson.start = lesson_params[:start]
	    @lesson.end = lesson_params[:end]
	 
	    if @group.save
            redirect_to lesson_path(@lesson, :faculty_id => @faculty.id, :group_id => @group.id)
	    else
	        render 'edit'
	    end
	end

    def show
		@faculty = Faculty.find(params[:faculty_id])
	    @group = @faculty.groups.select { |b| b.id.to_s == params[:group_id]}.first
        @lesson = @group.lessons.select { |b| b.id.to_s == params[:id]}.first
	  	@days = ["Monday",
	        "Tuesday",
	        "Wednesday",
	        "Thursday",
	        "Friday",
	        "Saturday"]
    end

	def destroy
		@faculty = Faculty.find(params[:faculty_id])
	    @group = @faculty.groups.select { |b| b.id.to_s == params[:group_id]}.first
		@group.lessons.delete_if{ |lesson| lesson.id.to_s == params[:id]}
	    if @group.save
            redirect_to group_path(@group, :faculty_id => @faculty.id)
	  	end
	end

    private
	    def lesson_params
	        params.require(:lesson).permit(:teacher, :name, :day, :start, :end, :group_id)
	    end
end
