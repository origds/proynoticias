class ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_report, :only => [:show, :edit, :update, :destroy, :approve, :publish]
  before_action :is_owner, :only => [:edit, :update, :destroy, :approve, :publish]
  before_action :is_admin, :only => [:approve, :publish, :not_published, :not_sent]

  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.where(:approved => true, :sent => true, :published => true)
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    if @report.viewed == false && current_user.role == 'admin'
      @report.viewed = true
      @report.save 
    end
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
    if @report.approved == false 
      respond_to do |format|
        format.html { render action: 'edit' }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back }
        format.json { head :no_content }
      end
    end
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)
    @report.viewed = false;
    @report.sent = false;
    @report.published = false;
    
    if current_user.role == "normal"
      @report.approved = false;
    else
      @report.approved = true;
    end

    @report.user_id = current_user.id;
    @report.author = current_user.email;
    respond_to do |format|
      if @report.save
        Notifier.report_notify(current_user).deliver
        format.html { redirect_to @report, notice: 'Noticia creada exitosamente.' }
        format.json { render action: 'show', status: :created, location: @report }
      else
        format.html { render action: 'new' }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, notice: 'Noticia actualizada exitosamente.' }
        format.json { render action: 'show', status: :ok, location: @report }
      else
        format.html { render action: 'edit' }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    if @report.approved == false || current_user.role == 'admin' ||
        (@report.approved == false && current_user.id == @report.user_id)
      @report.destroy
      respond_to do |format|
        format.html { redirect_to :back }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back }
        format.json { head :no_content }
      end
    end
  end

  #Aprueba una noticia para ser publicada y enviada posteriormente
  def approve
    if @report.approved == false
      if @report.update_attribute('approved', true)
        respond_to do |format|
          format.html { redirect_to @report, notice: 'Noticia aprobada.' }
          format.json { render action: 'show', status: :created, location: @report }
        end
      end
    else
      if @report.update_attribute('approved', false)
        respond_to do |format|
          format.html { redirect_to @report, notice: 'Noticia rechazada nuevamente.' }
          format.json { render action: 'show', status: :created, location: @report }
        end
      end
    end
  end

  #Para indicar que la noticia fue publicada
  def publish
    if @report.published == false
      if @report.update_attribute('published', true)
        respond_to do |format|
          format.html { redirect_to @report, notice: 'Noticia marcada como publicada.' }
          format.json { render action: 'show', status: :created, location: @report }
        end
      end
    else
      if @report.update_attribute('published', false)
        respond_to do |format|
          format.html { redirect_to @report, notice: 'Noticia marcada como no publicada.' }
          format.json { render action: 'show', status: :created, location: @report }
        end
      end
    end
  end

  #Para obtener las noticias que no han sido vistas
  def not_viewed
    @reports = Report.where(:approved => false)

    respond_to do |format|
      format.html
    end
  end

  #Para obtener las noticias que han sido vistas por algun admin pero no han sido aprobadas 
  def viewed
    @reports = Report.where(:viewed => true, :approved => false)

    respond_to do |format|
      format.html
    end
  end

  #Para obtener las noticias aprobadas pero que no han sido enviadas por mail
  def not_sent
    @reports = Report.where(:sent => false, :approved => true)

    respond_to do |format|
      format.html
    end
  end

  #Para obtener las noticias aprobadas pero que no han sido publicadas  
  def not_published
    @reports = Report.where(:published => false, :approved => true)

    respond_to do |format|
      format.html
    end
  end

  #Para obtener las noticias de cada usuario
  def my_reports
    @reports = Report.where(:user_id => current_user.id)

    respond_to do |format|
      format.html
    end
  end

  def aprobadas
    @reports = Report.where(:approved => true)
    respond_to do |format|
      format.html
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:title, :content, :source, :user_id, :author, :viewed, :approved, :sent, :published)
    end
end
