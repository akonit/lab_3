class SearchController < ApplicationController

	def by_group
	end

	def by_group_result
	  if params[:search] && params[:search] != nil && params[:search] != ""
	  	  @facultys = Faculty.where("groups.name" => params[:search])
          if @facultys != nil && @facultys.size > 0
          	  @faculty = @facultys.first
      	      @group = @faculty.groups.select { |b| b.name == params[:search]}.first
			  @days = ["Monday",
		        "Tuesday",
		        "Wednesday",
		        "Thursday",
		        "Friday",
		        "Saturday"]
	      else
	      	  redirect_to search_by_group_path
	      end
	  else
	      redirect_to search_by_group_path
	  end
	end
end
