class FacultysController < ApplicationController
	
	http_basic_authenticate_with name: "admin", password: "admin", except: [:index, :show]


	def new
		@faculty = Faculty.new
	end

    def create
    	@faculty = Faculty.new(faculty_params)
 
        if @faculty.save
            redirect_to @faculty
	    else
	        render 'new'
	    end
    end

	def edit
	    @faculty = Faculty.find(params[:id])
	end

	def update
	    @faculty = Faculty.find(params[:id])
	 
	    if @faculty.update_attributes(faculty_params)
	        redirect_to @faculty
	    else
	        render 'edit'
	    end
	end

    def show
        @faculty = Faculty.find(params[:id])
    end

    def index
        @facultys = Faculty.all
    end

	def destroy
	  	@faculty = Faculty.find(params[:id])
	  	@faculty.destroy
	 
	  	redirect_to facultys_path
	end

    private
	    def faculty_params
	        params.require(:faculty).permit(:number, :name)
	    end
end
