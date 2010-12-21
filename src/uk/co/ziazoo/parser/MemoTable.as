/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 18/12/2010
 * Time: 16:44
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  import flash.utils.Dictionary;

  public class MemoTable implements IMemoTable
  {
    private var byId:Dictionary;

    public function MemoTable()
    {
      byId = new Dictionary();
    }

    public function hasResult(id:String, index:int):Boolean
    {
      var byIndex:Dictionary = byId[id] as Dictionary;

      if (!byIndex)
      {
        return false;
      }

      return byIndex[index] != null;
    }

    public function saveResult(id:String, index:int, result:Result):void
    {
      if (!byId[id])
      {
        byId[id] = new Dictionary();
      }
      trace("Save " + result.instance + " for " + id + " at " + index);
      byId[id][index] = result;
    }

    public function getResult(id:String, index:int):Result
    {
      trace("Get " + id + " at " + index);
      return byId[id][index] as Result;
    }
  }
}
