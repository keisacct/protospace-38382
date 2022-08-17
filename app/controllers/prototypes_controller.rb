class PrototypesController < ApplicationController

    before_action :authenticate_user!
    before_action :move_to_index, only: :edit

    def index
        @prototype = Prototype.all
    end

    def new
        @prototype = Prototype.new
    end

    def create
        @prototype = Prototype.create(prototype_params)
        if @prototype.save
            redirect_to root_path
        else
            render :new
        end
    end

    def edit
        @prototype = Prototype.find(params[:id])
    end

    def update
        @prototype = Prototype.find(params[:id])
        @prototype.update(prototype_params)
        if @prototype.save
            redirect_to prototype_path
        else
            render :edit
        end
    end

    def destroy
        prototype = Prototype.find(params[:id])
        prototype.destroy
        redirect_to root_path
    end
    

    def show
        @prototype = Prototype.find(params[:id])
        @comment = Comment.new
        @comments = @prototype.comments.includes(:user)
    end

    


    private
    def prototype_params
        params.require(:prototype).permit(:image, :title, :catch_copy, :concept).merge(user_id: current_user.id)
    end

    def move_to_index
        prototype = Prototype.find(params[:id])
        unless user_signed_in? && prototype.user_id == current_user.id 
            redirect_to action: :index
        end
    end

end
