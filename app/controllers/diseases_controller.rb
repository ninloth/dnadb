class DiseasesController < ApplicationController

	before_action :set_disease, only: [:show, :edit, :update, :destroy]
	before_action :is_user, only: [:new, :edit, :update, :destroy, :create, :show]

	def edit
	end

	def show
	end

	def new
		@disease = Disease.new
	end

	def create
    	@disease = Disease.new disease_params
    	if(params[:gene_id])
    		@disease.gene_id = params[:gene_id]
    	else
    		@disease.gene_id = :gene_id;
    	end
    	 respond_to do |format| 
		    if @disease.save
		        format.html { redirect_to @disease, notice: 'Disease foi criado com sucesso.' }
		        format.json { render :show, status: :created, location: @disease }
		    else
		        format.html { render :new }
		        format.json { render json: @disease.errors, status: :unprocessable_entity }
		    end
	    end
	end

	def update
		respond_to do |format|
			if @disease.update(disease_params)
				format.html { redirect_to @disease, notice: 'Disease was successfully updated.' }
				format.json { render :show, status: :ok, location: @disease }
			else
				format.html { render :edit }
				format.json { render json: @disease.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
	    @disease.destroy
	    redirect_to genes_path
	end

	private


   def disease_params
      params.require(:disease).permit(:name, :quantity ,:state, :gene_id)
   end

   def set_disease
      @disease = Disease.find(params[:id])
    end

    def is_user
		unless user_signed_in?
	      	redirect_to genes_path, :alert => "Access denied.  Please sign in."
	    end   
   end
end
