package Email::Store::Vote;
use base "Email::Store::DBI";
use strict;
__PACKAGE__->table("vote");

__PACKAGE__->columns( Primary => qw[ id  ] );
__PACKAGE__->columns( Other   => qw[ mail ] );
__PACKAGE__->has_a(mail => "Email::Store::Mail");
Email::Store::Mail->has_many(votes => "Email::Store::Vote");

__PACKAGE__->set_sql( popular => qq{
    SELECT mail.message_id, count(vote.mail) AS votes 
    FROM mail, vote
    WHERE mail.message_id = vote.mail
    GROUP BY vote.mail 
    ORDER BY votes DESC
});

1;


__DATA__

CREATE TABLE IF NOT EXISTS vote (
    id           integer NOT NULL PRIMARY KEY AUTO_INCREMENT,
    mail         varchar(255) NOT NULL
);

