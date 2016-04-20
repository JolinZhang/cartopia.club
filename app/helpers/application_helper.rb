module ApplicationHelper
	def pagination(items)
		items.paginate(:page => params[:page], :per_page => 5)
	end
end
