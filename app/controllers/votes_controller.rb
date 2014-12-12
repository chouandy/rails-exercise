class VotesController < ApplicationController
  before_filter :set_votable, only: [:upvote, :downvote]

  def upvote
    if current_user
      # TODO: up a vote with user
      @votable.vote_by(voter: current_user)
      respond_to { |format| format.js } if current_user.voted_up_on? @votable
    else
      respond_to do |format|
        format.js { render js: "alert('#{t(:login_first)}')" }
      end
    end
  end

  def downvote
    # TODO: down a vote with user
    @votable.vote_by(voter: current_user, vote: 'bad')
    respond_to do |format|
      format.js { render 'upvote' }
    end if current_user.voted_down_on? @votable
  end

  private

    def set_votable
      @votable = params[:model].classify.constantize.find(params[:id])
    end
end
