from typing_extensions import TypedDict
from langgraph.graph import StateGraph,START,END
class State(TypedDict):
    query:str
    result:str
# Our state stores the user query and the final result.

def router(state:State):
    if 'calculator' in state['query'].lower():
        return 'calculator'
    return 'normal'
def calculator_node(state:State):
    return {
        'result':'calculator selected'
    }
def normal_node(state:State):
    return {
        'result':'LLM selected '
    }
def router_node(state:State):
    return state
# These are simple placeholder nodes for now.
# They help us understand routing before adding actual calculation and Ollama calls.

# Build the graph
builder=StateGraph(State)
builder.add_node('router',router)
builder.add_node('calculator',calculator_node)
builder.add_node('normal',normal_node)

# building the edge: 
builder.add_edge(START,'router')
builder.add_conditional_edges(
    'router',
    router,
    {
        'calculator':'calculator',
        'normal':'normal'
    }
)
builder.add_edge('calculator',END)
builder.add_edge('normal',END)
# now we will compile the graph:
graph=builder.compile()

result=graph.invoke(
    {
        'query':'calculate 25*4?',
        'result':''
    }
)
print(result)