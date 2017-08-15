# To seed data in a clean manner, run this command:
# rake db:drop db:create db:migrate db:seed

Game.create([{ created_by: 'Cashier 2: Joanne Davis' }])

Player.create([{ game_id: '1', name: 'Daisy Duck' }, { game_id: '1', name: 'Goofy Dawg' }])

Frame.create([{
# Player Daisy Duck
  frame_number: 1,
  ball_one_pins: 6,
  ball_two_pins: 2,
  ball_three_pins: 0,
  score: 8,
  player_id: 1
},
{ frame_number: 2,
  ball_one_pins: 7,
  ball_two_pins: 3, # spare
  ball_three_pins: 0,
  score: 21,
  player_id: 1
},
{ frame_number: 3,
  ball_one_pins: 3,
  ball_two_pins: 3,
  ball_three_pins: 0,
  score: 27,
  player_id: 1
},
{ frame_number: 4,
  ball_one_pins: 7,
  ball_two_pins: 0,
  ball_three_pins: 0,
  score: 34,
  player_id: 1
},
{ frame_number: 5,
  ball_one_pins: 9,
  ball_two_pins: 0,
  ball_three_pins: 0,
  score: 43,
  player_id: 1
},
{ frame_number: 6,
  ball_one_pins: 6,
  ball_two_pins: 2,
  ball_three_pins: 0,
  score: 51,
  player_id: 1
},
{ frame_number: 7,
  ball_one_pins: 9,
  ball_two_pins: 1, # spare
  ball_three_pins: 0,
  score: 69,
  player_id: 1
},
{ frame_number: 8,
  ball_one_pins: 8,
  ball_two_pins: 0,
  ball_three_pins: 0,
  score: 77,
  player_id: 1
},
{ frame_number: 9,
  ball_one_pins: 8,
  ball_two_pins: 1,
  ball_three_pins: 0,
  score: 86,
  player_id: 1
},
{ frame_number: 10,
  ball_one_pins: 3,
  ball_two_pins: 3,
  ball_three_pins: 0,
  score: 92,
  player_id: 1
},
# Player Goofy Dawg
{ frame_number: 1,
  ball_one_pins: 10, # strike
  ball_two_pins: 0,
  ball_three_pins: 0,
  score: 19,
  player_id: 2
},
{ frame_number: 2,
  ball_one_pins: 4,
  ball_two_pins: 5,
  ball_three_pins: 0,
  score: 28,
  player_id: 2
},
{ frame_number: 3,
  ball_one_pins: 7,
  ball_two_pins: 0,
  ball_three_pins: 0,
  score: 35,
  player_id: 2
},
{ frame_number: 4,
  ball_one_pins: 4,
  ball_two_pins: 4,
  ball_three_pins: 0,
  score: 43,
  player_id: 2
},
{ frame_number: 5,
  ball_one_pins: 5,
  ball_two_pins: 4,
  ball_three_pins: 0,
  score: 52,
  player_id: 2
},
{ frame_number: 6,
  ball_one_pins: 3,
  ball_two_pins: 3,
  ball_three_pins: 0,
  score: 58,
  player_id: 2
},
{ frame_number: 7,
  ball_one_pins: 6,
  ball_two_pins: 0,
  ball_three_pins: 0,
  score: 64,
  player_id: 2
},
{ frame_number: 8,
  ball_one_pins: 1,
  ball_two_pins: 4,
  ball_three_pins: 0,
  score: 69,
  player_id: 2
},
{ frame_number: 9,
  ball_one_pins: 3,
  ball_two_pins: 1,
  ball_three_pins: 0,
  score: 73,
  player_id: 2
},
{ frame_number: 10,
  ball_one_pins: 10, # strike
  ball_two_pins: 9,
  ball_three_pins: 0,
  score: 92,
  player_id: 2
}])
