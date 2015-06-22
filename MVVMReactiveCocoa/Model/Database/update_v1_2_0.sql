DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Repository;

create table if not exists User (id integer primary key, rawLogin text, login text, name text, bio text, email text, avatar_url text, html_url text, blog text, company text, location text, collaborators integer, public_repos integer, owned_private_repos integer, public_gists integer, private_gists integer, followers integer, following integer, disk_usage integer);
create table if not exists Repository (id integer primary key, name text, owner_login text, owner_avatar_url text, description text, language text, pushed_at text, created_at text, updated_at text, clone_url text, ssh_url text, git_url text, html_url text, default_branch text, private integer, fork integer, watchers_count integer, forks_count integer, stargazers_count integer, open_issues_count integer, subscribers_count integer);
create table if not exists Search (id integer primary key autoincrement, keyword text, searched_at text, userId integer);
create table if not exists User_Following_User (id integer primary key autoincrement, userId integer, targetUserId integer);
create table if not exists User_Starred_Repository (id integer primary key autoincrement, userId integer, repositoryId integer);