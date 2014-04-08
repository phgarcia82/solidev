class Notifications < ActionMailer::Base

  def new_proposal_email(proposal)
    @proposal = proposal
    @exchange =  Exchange.find(@proposal.exchange_id)
    @author_exchange = User.find(@exchange.user_id)
    @url  = 'http://solidareit.be/en/users/sign_in'
    mail(to: @author_exchange.email, subject: 'New proposal on Solidare-it !')
  end


  def new_comment_email(comment)

    @comment = comment
    @proposal = Proposal.find(@comment.proposal_id)
    @exchange = Exchange.find(@proposal.exchange_id)

    @comments = Comment.where("(proposal_id = ?) AND NOT(user_id = ?)",@comment.proposal_id,@comment.user_id)

    @comments.map {|com| com.user_id  }.uniq.each { |com2|
      @user_comment = User.find(com2)
      mail(to: @user_comment.email, subject: 'New comment on Solidare-it !')
      mail.deliver
    }

  end

end
