import UIKit

import Foundation

// Protocolo para representar um item que pode ser marcado como concluído
protocol Completable {
    var isCompleted: Bool { get set }
    func markAsCompleted()
}

// Protocolo para representar um item que tem um título
protocol Titled {
    var title: String { get }
}

// Struct que representa uma tarefa
class Task: Completable, Titled {
    let title: String
    var isCompleted: Bool = false
    
    init(title: String) {
        self.title = title
    }
    
    func markAsCompleted() {
        isCompleted = true
    }
}


// Classe que gerencia a lista de itens que podem ser marcados como concluídos
class ItemManager<T: Completable & Titled> {
    var items: [T] = []
    
    func add(item: T) {
        items.append(item)
    }
    
    func listPendingItems() {
        print("Itens pendentes:")
        for (index, item) in items.enumerated() where !item.isCompleted {
            print("\(index + 1). \(item.title)")
        }
    }
}

// Criação do gerenciador de tarefas
let taskManager = ItemManager<Task>()

// Adicionar tarefas
taskManager.add(item: Task(title: "Fazer compras"))
taskManager.add(item: Task(title: "Estudar Swift"))
taskManager.add(item: Task(title: "Fazer exercícios"))

// Marcar uma tarefa como concluída
taskManager.items[0].markAsCompleted()

// Listar tarefas pendentes
taskManager.listPendingItems()
