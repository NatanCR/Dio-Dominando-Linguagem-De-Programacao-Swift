import UIKit

import Foundation

// Enum para representar o estado de uma tarefa
enum TaskState {
    case pending, completed
}

// Struct que representa uma tarefa
struct Task {
    let title: String
    var state: TaskState
    
    init(title: String, state: TaskState) {
        self.title = title
        self.state = state
    }
}

// Classe que gerencia a lista de tarefas
class TaskManager {
    var tasks: [Task] = []
    
    // Função para adicionar uma tarefa à lista
    func addTask(title: String) {
        let task = Task(title: title, state: .pending)
        tasks.append(task)
    }
    
    // Função para marcar uma tarefa como concluída
    func completeTask(index: Int) {
        if index >= 0 && index < tasks.count {
            tasks[index].state = .completed
        }
    }
    
    // Função que lista as tarefas pendentes usando concorrência
    func listPendingTasks() {
        let concurrentQueue = DispatchQueue(label: "com.example.taskManager", attributes: .concurrent)
        var pendingTasks: [Task] = []
        
        concurrentQueue.sync {
            pendingTasks = tasks.filter { $0.state == .pending }
        }
        
        concurrentQueue.async {
            print("Tarefas pendentes:")
            for (index, task) in pendingTasks.enumerated() {
                print("\(index + 1). \(task.title)")
            }
        }
    }
}

// Criação do gerenciador de tarefas
let taskManager = TaskManager()

// Adicionar tarefas
taskManager.addTask(title: "Fazer compras")
taskManager.addTask(title: "Estudar Swift")
taskManager.addTask(title: "Fazer exercícios")

// Marcar uma tarefa como concluída
taskManager.completeTask(index: 0)

// Listar tarefas pendentes usando concorrência
taskManager.listPendingTasks()

// Aguardar um tempo para permitir a execução das tarefas em segundo plano
sleep(2)
