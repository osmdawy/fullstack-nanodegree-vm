-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.


CREATE DATABASE tournament;
\c tournament;
CREATE TABLE players(id serial PRIMARY KEY,name text);
CREATE TABLE matches(winner serial REFERENCES players(id), loser serial REFERENCES players(id),PRIMARY KEY(winner,loser));
CREATE VIEW standings as Select players.id, players.name,count(case matches.winner when players.id then 1 else null end) as wins,
        count(matches.winner = players.id or matches.loser = players.id) as matches from players left join matches
        on (players.id = matches.winner or players.id = matches.loser) group by players.id order by wins desc;



