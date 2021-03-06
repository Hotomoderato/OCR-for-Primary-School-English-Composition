import tensorflow as tf

from tensorflow.python.platform import gfile

graph = tf.get_default_graph()

graphdef = graph.as_graph_def()

_ = tf.train.import_meta_graph("model/model/model.ckpt.meta")

summary_write = tf.summary.FileWriter("./model/graph" , graph)

summary_write.close()
