if User.first.blank?
  team = Team.create(name: 'RED', description: 'a financial team with red attribute')
  user = User.create(username: 'taufan_arif', password: 'password', team_id: team.id)
  wallet = Wallet.create(walletable: user, balance: 10_000)
end
