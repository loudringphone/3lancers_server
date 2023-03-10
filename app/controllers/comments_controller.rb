class CommentsController < ApplicationController
  skip_before_action :is_authorized
  before_action :set_comment, only: %i[ show edit update destroy ]
  
  # GET /comments OR  /comments.json
  def index
    @comments = Comment.all
    render :json => @comments.to_json(:include => [:user])
  end

  def show
    @comment = Comment.find(params[:id])
  end

  # POST
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to comment_url(@comment), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comment_url(@comment), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  private
  def comment_params
    params.require(:comment).permit(:user_id, :request_id, :content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

end
