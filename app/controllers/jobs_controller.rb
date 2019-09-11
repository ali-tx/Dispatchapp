  class JobsController < ApplicationController
    # before_action :is_login?
    before_action :authenticate_user!




  def index
    @job = Job.all
    @request = Request.where(:user_id => current_user.id)
    if params[:search]
      @recipes = Job.search(params[:search]).order("created_at DESC")
    else
      @recipes = Job.all.order("created_at DESC")
    end
  end
    def assign_job_update
      @user=User.find(params[:job][:user_id])

      @job = Job.find(params[:job_id])
      @job.status = "Pending"
      if @job.update(jobs_params) && @user.update_columns(job_assigned: true )
        redirect_to @job
      else
        render 'jobs/show'

      end

      @request =Request.new(user_id: params[:job][:user_id],job_id: params[:job_id])
      @request.save
    end
    def accept_job
      @request=Request.find(params[:request_id])
      @job = Job.find(params[:job_id])
      if @job.update_columns(status: "Accepted",user_id: true ) && @user.update_columns(job_assigned: true )
        @request.destroy
        redirect_to @job
      end
    end

    def reject_job
      @user=User.find(current_user.id)
      @request=Request.find(params[:request_id])
      @job = Job.find(params[:job_id])
      if @job.update_columns(status: "Pending",user_id: nil ) && @user.update_columns(job_assigned: false )
        @request.destroy
        redirect_to @job
      end
    end

    def assignjob
      @job = Job.find(params[:job_id])
      @users = User.where(:admin => false,:job_assigned => false)
      if @job.user_id != nil
        redirect_to root_path
      end
    end

    def sub
      @job = Job.find(params[:job_id])
      @user = User.find(params[:job][:user_id])
      @job.user = @user
      @request = Request.new(:user => @user,:job => @job)
      @job.save
      @request.save
      redirect_to jobs_path
    end

    def close_job

      @job = Job.find(params[:job_id])
      @request=Request.find_by_job_id(@job.id)
      @user=User.find(@job.user_id)
      if @request.present?
        @request.destroy
      end
      if @job.update_columns(status: "Complete",user_id: nil ) && @user.update_columns(job_assigned: false )
        redirect_to @job
      end
    end
  def show
    @job = Job.find(params[:id])
  end
  def new
    @job = Job.new
  end
  def edit
    @job = Job.find(params[:id])
  end
  def create
    @job = Job.new(jobs_params)
    if @job.save
      redirect_to @job
    else
      render 'new'
    end
  end
  def update
    @job = Job.find(params[:id])
    if @job.update(jobs_params)
      redirect_to @job
    else
      render 'edit'
    end
  end
  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to jobs_path
  end
      end
    private
  def jobs_params
    params.require(:job).permit(:details, :status,:source_long, :source_lat, :destination_long, :destination_lat)
  end

