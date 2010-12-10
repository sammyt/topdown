/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 08/12/2010
 * Time: 19:28
 * To change this template use File | Settings | File Templates.
 */
package ziazoo.combinators
{
  public class Failure implements IResult
  {
    public var msg:String;

    public function Failure(msg:String = "")
    {
      this.msg = msg;
    }
  }
}
