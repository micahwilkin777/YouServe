class AssignmentsController < ApplicationController
	def new
		@assignment = Assignment.new

	end

	def create

		 @assignment = Assignment.new(assignment_params)
		if @assignment.save!
			flash[:success] = "Task assigned"
			

		else
			flash[:error] = "Task was not assigned"

		end
		redirect_to @assignment.task
	end




	def accept
		@assignment = Assignment.find(params[:id])
		if @assignment.accept!
			flash[:success] = "Assignment accepted"
		else flash[:error] = "Assignment was not accepted"
			
		end
		redirect_to dashboard_path

	end



	def reject
		@assignment = Assignment.find(params[:id])
		if @assignment.reject!
			flash[:success] = "Assignment rejected"
		else 
			flash[:error] = "Assignment was not rejected"
			
		end
		redirect_to dashboard_path
	end



	def completed
		@assignment = Assignment.find(params[:id])
		if @assignment.complete!
			flash[:success] = "Congrats! Admin will verify that assignment has been completed"

		else
			flash[:error] = "Sorry, something is wrong"
			end
		redirect_to dashboard_path
	end


	def confirmed
		@assignment = Assignment.find(params[:id])
		if @assignment.verify!
			@assignment.update_attribute(:confirmed_at, Time.now)
			flash[:success] = "Completion of assignment verified."
		else
			flash[:error] = "Completion of assignment not confirmed"
		end
		redirect_to dashboard_path
	end



	def confirmation_rejected
		@assignment = Assignment.find(params[:id])
		if @assignment.unconfirm!
			flash[:success] = "Comfirmation of assignment completion was rejected"
		else
			flash[:error] = "Comfirmation was not rejected"
			end
		redirect_to dashboard_path

	end


	def destroy

	end

private
def assignment_params
	params.require(:assignment).permit(:task_id, :user_id, :free, :id)
end

end
