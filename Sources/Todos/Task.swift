import Foundation
import RealmSwift

public class Task: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) public var id: ObjectId
    @Persisted public var title = ""
    @Persisted public var completed = false
}
