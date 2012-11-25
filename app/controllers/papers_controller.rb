class PapersController < ApplicationController
  before_filter :check_signin
  before_filter :auth_me, :only => [:show, :complete, :result, :destroy, :update]

  def show
    @survey = @paper.survey
  end

  def complete
    if @paper.completed || @paper.update_attribute(:completed, true)
      redirect_to result_paper_path(@paper)
    else
      redirect_to paper_path(@paper)
    end
  end

  def update
    unless params[:paper][:questions].nil?
      logger.info "###############2"
      params[:paper][:questions] = params[:paper][:questions].map {|key, value|
        type = value[:type].to_i
        unless value[:examples].nil?
          reply = Reply.find_or_create_by(paper_id: @paper._id, question_id: key)
          if type == 0
            value[:examples].map {|key, value|
              logger.info value[:content]
              reply.update_attribute(:content, value[:content])
            }
          elsif type == 1
            examples = []

            example = Example.find(value[:examples])
            examples.push(example) unless example.nil?

            reply.examples = examples
            reply.save
          elsif type == 2
            examples = []

            value[:examples].map {|key, value|
              if value == 1
              	example = Example.find(key)
                examples.push(example) unless example.nil?
              end
            }

            reply.examples = examples
            reply.save
          else
            # todo
          end
        end
      }
    end
    redirect_to back
  end

  def result
    if @paper.completed
      @survey = @paper.survey
    else
      redirect_to paper_path(@paper)
    end
  end

  def destroy
    @paper.destroy
    redirect_to root_path
  end

  def me
    @papers = current_user.papers
  end

  private
  def auth_me
    @paper = Paper.find(params[:id])
    if @paper.user == nil || signed_in? && @paper.user == current_user
    else
      redirect_to signin_path
    end
  end
end
