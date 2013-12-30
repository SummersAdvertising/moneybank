class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  
  before_filter :check_login, only: [ :index, :show, :destroy ]
  
  layout false, except: [ :new ]

  def logout
  
  	session.delete( :is_login )
  	
  	respond_to do | format |	
  		format.html { redirect_to :action => :login }
  	end
  
  end

  def login
    
  	respond_to do | format |
  		if session[ :is_login ] || ( params[ :submit ] && ( !params[ :password ].nil? && !params[ :username ].nil?  ) && ( Digest::SHA1.hexdigest( params[ :password ] ) == '9e59dbb0add651a3b414f332e42aa337ad63b4c3' && Digest::SHA1.hexdigest( params[ :username ] ) == 'd033e22ae348aeb5660fc2140aec35850c4da997' ) )
	  		
	  		session[ :is_login ] = true
	  		
	  		format.html { 
	  			if params[ :last_url ].nil?
	  				redirect_to :action => :index
	  			else
	  				redirect_to params[ :last_url ]
	  			end
	  		 }
	  		
  		else
  			format.html
  		end
  	end
  
  end

  # GET /tickets
  # GET /tickets.json
  def index
    @tickets = Ticket.order( :created_at => :desc ).page( params[ :page ] ).per( 20 )
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
    
    respond_to do | format |
    	if params[ :mobile ].nil?
    		format.html {}
    	else
    		format.html { render :template => 'tickets/mobile', layout: false }    	
    	end
    end
    
  end


  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)
    respond_to do |format|
      if @ticket.save
      
      	TicketsMailer.new_ticket(@ticket).deliver
      
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ticket }
        format.js {  }
      else
        format.html { render action: 'new' }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
        format.js { render 'error' }
      end
    end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end
    
    def check_login
    	if session[ :is_login ] != true
    		redirect_to :action => :login
    	end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:name, :gender, :phone, :email, :quota, :status)
    end
end
