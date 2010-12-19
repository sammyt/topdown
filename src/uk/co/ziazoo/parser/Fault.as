/**
 * Created by IntelliJ IDEA.
 * User: sammy
 * Date: 19/12/2010
 * Time: 16:50
 * To change this template use File | Settings | File Templates.
 */
package uk.co.ziazoo.parser
{
  public class Fault extends Result
  {
    public function Fault(message:String)
    {
      super(false, false);
      failures.push(message);
    }
  }
}
