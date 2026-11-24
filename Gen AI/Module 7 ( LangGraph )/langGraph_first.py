# typedict: A special class that lets you describe the exact shape of a dictionary: which keys it must have and what type each value should be.

from typing_extensions import TypedDict
class State(TypedDict):
    number:int
    result:int
def double_number(state:State):
    result=state['number']*2
    return {
        'result':result
    }

from langgraph.graph import StateGraph,START,END
import warnings
warnings.filterwarnings('ignore')
builder=StateGraph(State)
builder.add_node('double',double_number)
builder.add_edge(START,'double') # 	Defines the starting node
builder.add_edge('double',END) # Defines where execution finishes
graph=builder.compile() # 	Builds an executable graph
output=graph.invoke({
    'number':10,
    'result':0
})
# invoke means calling in langgraph it is method to run the graph
print(f'the double of the number is : ',output)

""" 
Important concepts to remember
- StateGraph creates the graph.
- TypedDict defines the state structure.
- add_node() registers functions.
- add_edge() connects nodes.
- START marks the beginning.
- END marks the completion.
- compile() prepares the graph for execution.
- invoke() executes it.

"""