class IdeasController < ApplicationController
    def index
      @ideas =Idea.all
      @debit_expense = Idea.where('amount > 0').sum(:amount)
      @credit_expense= Idea.where('amount < 0').sum(:amount)
      @total=@debit_expense+@credit_expense
    end
    def create
        @idea = Idea.create(idea_params)
        if @idea.valid?
          flash[:success]="Your expense has been posted"
        else
          flash[:alert]=@idea.errors.full_messages.to_sentence
        end
        redirect_to root_path
      end
    def edit
        @idea = Idea.find(params[:id])
    end
    def update
        @idea = Idea.find(params[:id])
        if @idea.update(idea_params)
          flash[:success]="Your expense has been successfully updated."
          redirect_to root_path
        else
          redirect_to edit_idea_path(params[:id])
        end
      end
      def destroy
        @idea = Idea.find(params[:id])
        @idea.destroy
        flash[:success]="The expense was successfully deleted."
        redirect_to root_path
      end
    private

    def idea_params
      params.require(:idea).permit(:title, :amount, :date)
    end
end
