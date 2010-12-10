/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 04/12/2010
 * Time: 15:53
 * To change this template use File | Settings | File Templates.
 */
package ziazoo.combinators
{
  public class ParserState
  {
    private var input:String;
    public var index:int = 0;

    public function ParserState(input:String)
    {
      this.input = input;
    }

    public function at(i:int):String
    {
      return input.charAt(i + index);  
    }

    public function subStr(len:int):String
    {
      return input.substr(index, len);
    }

    public function subStrFrom(start:int, end:int):String
    {
      return input.substring(start, end);
    }

    public function incr():void
    {
      index ++;
    }

    public function move(i:int):void
    {
      index += i;
    }

    public function get len():int
    {
      return input.length - index;
    }
  }
}
