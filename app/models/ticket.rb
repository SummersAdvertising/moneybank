# encoding: utf-8
class Ticket < ActiveRecord::Base

	validates_presence_of :name, :message => '請輸入您的名字'
	validates_presence_of :gender, :message => '請選擇您的性別'
	validates_presence_of :phone, :message => '請輸入您的聯絡電話'
	validates_presence_of :quota, :message => '請選擇您想貸款的額度區間'
	
	validates_format_of :phone, :with => /[\d\-\#\(\)]+/, :message => '電話格式有誤'
	validates_format_of :email, :with => /([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4})*/, :message => '信箱格式有誤'


end
