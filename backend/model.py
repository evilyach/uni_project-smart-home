from main import db

class DeviceType(db.Model):
    ''' Device Type database model '''
    __tablename__ = 'device_type'

    id = db.Colunn(db.Integer, primary_key=True)
    typename = db.Colunn(db.String(64), index=True, unique=True)
    description = db.Column(db.Text, index=True)

    def __init__(self, id, typename, description):
        ''' Create new database record '''
        self.id = id
        self.typename = typename
        self.description = description

    def __repr__(self):
        return '<DeviceType {}>'.format(self.typename)


class EstatesAndDevices(db.Model):
    ''' Estated and Devices database model '''
    id = db.Column(db.Integer, primary_key=True)
    realestate_id = db.Column(db.Integer, foreign_key='devicetype.id')