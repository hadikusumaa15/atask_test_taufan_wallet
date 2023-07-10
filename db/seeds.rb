if User.first.blank?
  red_team = Team.create(name: 'the_red_team', description: 'a financial team with red attribute')
  red_user_1 = User.create(username: 'red_user_1', password: 'password', team_id: red_team.id, is_team_admin: true)
  red_user_2 = User.create(username: 'red_user_2', password: 'password', team_id: red_team.id)
  red_wallet_1 = Wallet.create(walletable: red_user_1)
  red_wallet_2 = Wallet.create(walletable: red_user_2)
  team_red_wallet = Wallet.create(walletable: red_team)

  blue_team = Team.create(name: 'the_blue_team', description: 'a financial team with blue attribute')
  blue_user_1 = User.create(username: 'blue_user_1', password: 'password', team_id: blue_team.id, is_team_admin: true)
  blue_user_2 = User.create(username: 'blue_user_2', password: 'password', team_id: blue_team.id)
  blue_wallet_1 = Wallet.create(walletable: blue_user_1)
  blue_wallet_2 = Wallet.create(walletable: blue_user_2)
  team_blue_wallet = Wallet.create(walletable: blue_team)

  100.times do
    Transaction.create(
      source_wallet_id: nil,
      target_wallet_id: red_wallet_1.id,
      amount: 1000,
      description: 'deposit money'
    )

    Transaction.create(
      source_wallet_id: red_wallet_1.id,
      target_wallet_id: red_wallet_2.id,
      amount: 100,
      description: 'wallet transfer'
    )

    Transaction.create(
      source_wallet_id: blue_wallet_1.id,
      target_wallet_id: red_wallet_1.id,
      amount: 100,
      description: 'wallet transfer'
    )

    Transaction.create(
      source_wallet_id: red_wallet_1.id,
      target_wallet_id: nil,
      amount: 100,
      description: 'withdraw money to cash'
    )
  end
end
