create keyspace posts_ks
    WITH replication = {'class' : 'SimpleStrategy', 'replication_factor' : 1};

use posts_ks;

-- таблица для запросов 1-3
create table user_posts (
    user_id int,
    post_id int,
    content text,
    created_at timestamp,
    username text,
    PRIMARY KEY (user_id, created_at)
) with clustering order by (created_at asc);

insert into user_posts (user_id, post_id, content, created_at, username) values(1, 1, 'post1 cont', '2026-03-12 23:48:23', 'user1');
insert into user_posts (user_id, post_id, content, created_at, username) values(1, 2, 'post2 cont', '2026-03-11 23:48:23', 'user1');
insert into user_posts (user_id, post_id, content, created_at, username) values(1, 3, 'post3 cont', '2026-03-12 23:53:23', 'user1');
insert into user_posts (user_id, post_id, content, created_at, username) values(2, 4, 'post21 cont', '2026-03-12 23:20:23', 'user2');
insert into user_posts (user_id, post_id, content, created_at, username) values(3, 5, 'post22 cont', '2026-02-12 23:18:23', 'user3');
insert into user_posts (user_id, post_id, content, created_at, username) values(5, 6, 'post31 cont', '2026-03-12 13:48:23', 'user5');

-- Таблица для запроса 4
create table user_posts_with_topics (
    user_id int,
    username text,
    post_id int,
    created_at timestamp,
    topic_id int,
    PRIMARY KEY (topic_id, created_at, user_id)
) with clustering order by (created_at asc);

insert into user_posts_with_topics (user_id, username, post_id, created_at, topic_id) values(1, 'user1', 1, '2026-03-12 23:48:23', 1);
insert into user_posts_with_topics (user_id, username, post_id, created_at, topic_id) values(2, 'user2', 2, '2026-02-10 23:48:23', 1);
insert into user_posts_with_topics (user_id, username, post_id, created_at, topic_id) values(1, 'user1', 3, '2026-03-12 23:48:23', 3);
insert into user_posts_with_topics (user_id, username, post_id, created_at, topic_id) values(1, 'user1', 4, '2026-03-11 12:56:35', 1);
insert into user_posts_with_topics (user_id, username, post_id, created_at, topic_id) values(1, 'user1', 6, '2026-03-12 13:12:33', 1);
insert into user_posts_with_topics (user_id, username, post_id, created_at, topic_id) values(3, 'user3', 5, '2026-03-12 23:48:23', 2);
insert into user_posts_with_topics (user_id, username, post_id, created_at, topic_id) values(3, 'user3', 7, '2026-03-12 23:48:23', 1);

-- Запрос 1
select post_id, content, created_at from user_posts where user_id = 1;

-- Запрос 2
select post_id, content, created_at, username from user_posts where user_id = 1 limit 1;

-- Запрос 3
select post_id, content, created_at from user_posts where user_id = 1 and created_at > '2026-03-11 23:59:59';

-- Запрос 4
select user_id, username, post_id, created_at from user_posts_with_topics where topic_id = 1 and created_at >= '2026-03-12' and created_at < '2026-03-13';
