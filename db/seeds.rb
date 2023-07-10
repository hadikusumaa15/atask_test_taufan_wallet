if User.first.blank?
  red_team = Team.create(name: 'red', description: 'a financial team with red attribute')
  red_user_1 = User.create(username: 'red_user_1', password: 'password', team_id: red_team.id)
  red_user_2 = User.create(username: 'red_user_1', password: 'password', team_id: red_team.id)
  red_wallet_1 = Wallet.create(walletable: red_user_1, balance: 10_000)
  red_wallet_2 = Wallet.create(walletable: red_user_2, balance: 10_000)

  blue_team = Team.create(name: 'blue', description: 'a financial team with blue attribute')
  blue_user_1 = User.create(username: 'blue_user_1', password: 'password', team_id: blue_team.id)
  blue_user_2 = User.create(username: 'blue_user_1', password: 'password', team_id: blue_team.id)
  blue_wallet_1 = Wallet.create(walletable: blue_user_1, balance: 10_000)
  blue_wallet_2 = Wallet.create(walletable: blue_user_2, balance: 10_000)

  100.times do
    Transaction.create(
      source_wallet_id: red_wallet_1.id,
      target_wallet_id: red_wallet_2.id,
      amount: 100
    )

    Transaction.create(
      source_wallet_id: red_wallet_2.id,
      target_wallet_id: red_wallet_1.id,
      amount: 100
    )

    Transaction.create(
      source_wallet_id: blue_wallet_1.id,
      target_wallet_id: red_wallet_1.id,
      amount: 100
    )

    Transaction.create(
      source_wallet_id: red_wallet_1.id,
      target_wallet_id: blue_wallet_2.id,
      amount: 100
    )
  end
end
