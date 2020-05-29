require 'pry'

class Transfer
  attr_accessor :sender, :receiver, :amount, :status
  @@all=[]
  def initialize(sender, receiver, amount)
    @sender=sender
    @receiver=receiver
    @amount=amount
    @status="pending"
    @@all << self
  end
  def valid?
    self.sender.valid? && self.receiver.valid?
  end
  def execute_transaction
    #Replace this with case statements!
    if !(self.status=="complete") && self.valid?
      if self.sender.balance>self.amount 
        self.sender.balance-=self.amount
        self.receiver.balance+=self.amount
        self.status="complete"
        return
      else
        self.status="rejected"
      end
    elsif !(self.valid?)
      self.status="rejected"
    end
    return "Transaction rejected. Please check your account balance."
  end
  def reverse_transfer
    if self.status=="complete"
      self.sender.balance+=self.amount
      self.receiver.balance-=self.amount
      self.status="reversed"
    end
  end  
end
