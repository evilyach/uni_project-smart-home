import postgresql
import config


def authenticate(username, password):
    with postgresql.open(config.DATABASE_URI) as db:
        try:
            usernames_query = db.prepare('select t.* from public.get_users t')
            usernames = usernames_query()
        except:
            print('Could not get usernames from a DB')
            return None

        try:
            passwords_query = db.prepare('select t.* from public.get_passwords t')
            passwords = passwords_query()
        except:
            print('Could not get password hashes from a DB')
            return None

    for i, u in enumerate(usernames):
        if u[0] == username:
            index = i

    if password != passwords[index][0]:
        print('User {} has different password!'.format(username))
        return None

    return 'Ok'


def get_rights(username):
    with postgresql.open(config.DATABASE_URI) as db:
        try:
            rights_query = db.prepare("select get_rights('{}')".format(username))
            rights = rights_query()
        except:
            print('Could not get rights for user {}'.format(username))
            return None

    return rights


def get_user(username):
    with postgresql.open(config.DATABASE_URI) as db:
        try:
            name_query = db.prepare("select get_name('{}')".format(username))
            name = name_query()
        except:
            print('Could not get name for user {}'.format(username))
            return None

    return name


def register(user_account_type_id, name, username, password, email):
    # TODO: check for SQLi

    with postgresql.open(config.DATABASE_URI) as db:
        try:
            query = db.prepare("call register({}, '{}', '{}', '{}', '{}')".format(
                str(user_account_type_id),
                name,
                username,
                password,
                email
            ))

            user = query()
            return user

        except Exception as e:
            print('Could not register: {}'.format(str(e)))
            return None

    return None
