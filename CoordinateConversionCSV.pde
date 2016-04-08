Table table;
Table outputTable;

void setup() {
  outputTable = new Table();
  table = loadTable("Coordinates.csv", "header");
  outputTable.addColumn("# <label>");
  outputTable.addColumn("<x>");
  outputTable.addColumn("<y>");
  outputTable.addColumn("<z>");
 
  println(table.getRowCount() + " total rows in table ");
  
  for (TableRow row : table.rows()) {
    String img = row.getString("img");
    float azi = row.getFloat("azi");
    float ele = row.getFloat("ele");
    float dis = row.getFloat("dis");
    float[] vals = {0, 0, 0};
    vals = sphericalToCartesian(azi, ele, dis);
    println(vals);
    println();
     
    TableRow newRow = outputTable.addRow();
    newRow.setString("# <label>", img);
    newRow.setFloat("<x>", vals[0]);
    newRow.setFloat("<y>", vals[1]);
    newRow.setFloat("<z>", vals[2]);
  }
  
  saveTable(outputTable, "data/new.csv");
}


void draw () {
  
}

float[] sphericalToCartesian(float azi, float ele, float dis) {
  
  ele = 90-ele;
  azi = radians (azi);
  ele = radians (ele);
  float x = sin(ele) * cos(azi) * dis;
  float y = sin(ele) * sin(azi) * dis;
  float z = cos(ele) * dis;
  if(x < 0.0001){
    x=0;
  }
  if(y < 0.0001){
    y=0;
  }
  if(z < 0.0001){
    z=0;
  }
  float[] vals = {x, y, z};
  return vals;
}