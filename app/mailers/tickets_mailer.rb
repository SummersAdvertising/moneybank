#encoding: utf-8
class TicketsMailer < ActionMailer::Base  
  default from: "\"遠東授信專業團隊\" <bank0806@hotmail.com>"
  
  def new_ticket( ticket )
  	@ticket = ticket
  	
  	mail( :to => [ "bank0806@hotmail.com" ], :bcc => [ "yuzhe.c85@gmail.com" ], :subject => '[遠東信貸官網] 收到使用者詢問囉！' ) do | format |
  		format.html { render 'new_ticket' }
  	end
  
  end
  
  
end
