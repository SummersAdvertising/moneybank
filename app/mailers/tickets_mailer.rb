#encoding: utf-8
class TicketsMailer < ActionMailer::Base  
  default from: "\"遠東授信專業團隊\" adword@summers.com.tw"
  
  def new_ticket( ticket )
  	@ticket = ticket
  	
  	mail( :to => [ "yuzhe@summers.com.tw" ], :subject => '[遠東信貸官網] 收到使用者詢問囉！' ) do | format |
  		format.html {  }
  	end
  
  end
  
  
end
