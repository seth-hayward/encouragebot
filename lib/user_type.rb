class UserType < ActiveEnum::Base
	value :id => 0, :name => 'Permabanned'
	value :id => 2, :name => 'Tempbanned'
	value :id => 7, :name => 'UnconfirmedEmail'
	value :id => 10, :name => 'Normal'
	value :id => 25, :name => 'Mod'
	value :id => 100, :name => 'Admin'
end